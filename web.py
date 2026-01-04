from flask import Flask, request, jsonify
import os

app = Flask(__name__)


@app.route("/give", methods=["GET"])
def run_command():
    player = request.args.get("player")
    os.system(
        'docker exec -it `docker container ls | grep papermc | awk "{print $1}"` ./mcrcon-0.7.2-linux-x86-64-static/mcrcon -H localhost -p minecraft "mvinv give ' + player + ' PvP minecraft:wooden_axe"',
    )

    return jsonify({
        "stdout": 'done'
    })


if __name__ == "__main__":
    # Run only on localhost
    app.run(host="0.0.0.0", port=8000)
