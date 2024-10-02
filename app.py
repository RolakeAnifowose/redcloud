from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/api/v1', methods=['GET'])
def hello():
    return 'Hello World'

@app.route('/healthcheck', methods=['GET'])
def healthcheck():
    return 'Healthy'

# @app.route('/')
# def no_page():
#     return 'Invalid URL'

@app.errorhandler(404)
def page_not_found(e):
    return jsonify(error="Not found"), 404

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)