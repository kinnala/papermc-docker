from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)


@app.route("/give", methods=["GET"])
def run_command():
    player = request.args.get("player")

    try:
        result = subprocess.run(
            'docker exec -it `docker container ls | grep papermc | awk "{print $1}"` ./mcrcon-0.7.2-linux-x86-64-static/mcrcon -H localhost -p minecraft "mvinv give ' + player + ' PvP minecraft:wooden_axe"',
            capture_output=True,
            text=True,
            check=True
        )

        return jsonify({
            "stdout": result.stdout,
            "stderr": result.stderr
        })

    except subprocess.CalledProcessError as e:
        return jsonify({
            "error": "Command failed",
            "stdout": e.stdout,
            "stderr": e.stderr
        }), 500


if __name__ == "__main__":
    # Run only on localhost
    app.run(host="127.0.0.1", port=80)
