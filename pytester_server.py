from flask import Flask, render_template

app = Flask(__name__)

@app.route('/n8n', methods=['GET'])
def n8n():
    return render_template('send_to_n8n__localonly.html')

@app.route('/test', methods=['GET'])
def test():
    return render_template('test_json_slide_generation.html')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8082, debug=True)
