#!/usr/bin/python3
"""Exports all employees' TODO list data to a JSON file."""
import json
import requests


if __name__ == "__main__":
    users_url = "https://jsonplaceholder.typicode.com/users"
    todos_url = "https://jsonplaceholder.typicode.com/todos"

    users_response = requests.get(users_url)
    todos_response = requests.get(todos_url)

    if users_response.status_code != 200 or todos_response.status_code != 200:
        print("Error: Unable to fetch data from the API.")
        sys.exit(1)

    users_data = users_response.json()
    todos_data = todos_response.json()

    all_data = {}

    for user in users_data:
        user_id = str(user.get("id"))
        username = user.get("username")
        tasks = [{"task": task.get("title"), "completed": task.get("completed"), "username": username} for task in todos_data if task.get("userId") == user.get("id")]
        all_data[user_id] = tasks

    filename = "todo_all_employees.json"

    with open(filename, mode="w") as file:
        json.dump(all_data, file)
