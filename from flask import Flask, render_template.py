from flask import Flask, render_template, request
app = Flask(__name__, template_folder="templates")

@app.route("/idk", methods=['POST'])
def home():
    data = request.get_json()
    print(data)
    return render_template("main.html")

if __name__ == "__main__":
    app.run(debug=True)