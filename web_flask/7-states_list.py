#!/usr/bin/python3
"""
    Script that starts a Flask web application
    Must be listening on 0.0.0.0, port 5000
    Uses storage for fetchig data drom storange engine
"""
from flask import Flask, render_template
from models import storage

app = Flask(__name__)


@app.route('/state_list', strict_slashes=False)
def list_states():
    states = storage.all("state")
    return render_template('7-states_list.html', states=states)


@app.teardown_appcontext
def teardown_storage(exception):
    """Closes current db connection"""
    storage.close()


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
