#!/usr/bin/python3
"""Exports an employee's TODO list data to a JSON file."""
import json
import requests
import sys


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: ./2-export_to_JSON.py <employee_id>")
        sys.exit(1)

    employee_id = sys.argv[1]
    user_url = f"https://jsonplaceholder.typicode.com/users/{employee_id}"
    todos_url = f"https://jsonplaceholder.typicode.com/users/{employee_id}/todos"

    user_response = requests.get(user_url)
    todos_response = requests.get(todos_url)

    if user_response.status_code != 200 or todos_response.status_code != 200:
        print("Error: Unable to fetch data from the API.")
        sys.exit(1)

    user_data = user_response.json()
    todos_data = todos_response.json()

    username = user_data.get("username")
    tasks = [{"task": task.get("title"), "completed": task.get("completed"), "username": username} for task in todos_data]

    data = {employee_id: tasks}
    filename = f"{employee_id}.json"

    with open(filename, mode="w") as file:
        json.dump(data, file)
