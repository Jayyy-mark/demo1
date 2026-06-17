# <!--==========================================
#   MAIN ENTRY POINT OF THE APPLICATION
# ===========================================-->


from . import create_app

app = create_app()

if __name__ == "__main__":
    app.run(debug=False)
