from flask import Flask, Response
import pandas as pd
import io

app = Flask(__name__)

# Data Loading
def get_data_from_warehouse():
    # Use pd.read_sql() here
    data = {
        'Team': ['NYY', 'BOS', 'LAD'],
        'Avg_Release_Speed': [94.5, 92.1, 93.8],
        'Total_Home_Runs': [120, 98, 110],
        'Top_Player': ['Cole', 'Devers', 'Betts']
    }
    return pd.DataFrame(data)

@app.route('/api/v1/summary', methods=['GET'])
def get_summary_csv():
    """
    API Endpoint that generates a CSV file containing a summary of the data.
    """
    # Fetch Data
    df = get_data_from_warehouse()
    
    # Convert to CSV format in memory
    output = io.StringIO()
    df.to_csv(output, index=False)
    csv_data = output.getvalue()
    
    # Return as a downloadable file
    return Response(
        csv_data,
        mimetype="text/csv",
        headers={"Content-disposition": "attachment; filename=mlb_data_summary.csv"}
    )

if __name__ == '__main__':
    print("Starting API Server...")
    app.run(debug=True, port=5000)
