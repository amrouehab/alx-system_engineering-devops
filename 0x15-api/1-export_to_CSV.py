#!/usr/bin/python3
"""
Script that exports TODO list data for a given employee ID to CSV format
"""
import csv
import requests
import sys


def export_todo_to_csv(employee_id):
    """
    Exports the TODO list data for a specific employee to CSV format.
    Args:
        employee_id: Integer ID of the employee
    Returns:
        None (creates a CSV file)
    """
    # Base URL for the API
    base_url = "https://jsonplaceholder.typicode.com"
    
    # Get employee information
    user_url = f"{base_url}/users/{employee_id}"
    user_response = requests.get(user_url)
    user_data = user_response.json()
    
    # Get TODO list for employee
    todos_url = f"{base_url}/todos?userId={employee_id}"
    todos_response = requests.get(todos_url)
    todos_data = todos_response.json()
    
    # Prepare CSV filename
    csv_filename = f"{employee_id}.csv"
    
    # Write to CSV file
    with open(csv_filename, mode='w', newline='') as csv_file:
        writer = csv.writer(csv_file, quoting=csv.QUOTE_ALL)
        
        # Write each task to CSV
        for task in todos_data:
            writer.writerow([
                employee_id,
                user_data.get('username'),
                task.get('completed'),
                task.get('title')
            ])


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 1-export_to_CSV.py <employee_id>")
        sys.exit(1)
        
    try:
        employee_id = int(sys.argv[1])
        export_todo_to_csv(employee_id)
    except ValueError:
        print("Error: Employee ID must be an integer")
        sys.exit(1)
