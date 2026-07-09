from . import frontend_bp
from flask import render_template, request, jsonify, send_file, current_app
import os
import fitz
import tempfile

@frontend_bp.route('/publication', endpoint='publication')
def publication():
    return render_template('frontend/publication.html')

def extract_pdf_pages(input_path: str, output_path: str, start_page: int, end_page: int):
    """
    Extract pages from a PDF and save as a new file.
    """
    doc = fitz.open(input_path)
    new_doc = fitz.open()

    total_pages = len(doc)

    if start_page < 1:
        start_page = 1

    if end_page > total_pages:
        end_page = total_pages

    if start_page > end_page:
        raise ValueError("start_page cannot be greater than end_page")

    for page_num in range(start_page - 1, end_page):
        new_doc.insert_pdf(doc, from_page=page_num, to_page=page_num)

    new_doc.save(output_path)
    new_doc.close()
    doc.close()

    return output_path

@frontend_bp.route('/publication/extract-pdf', methods=['POST'])
def extract_pdf():
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400
    
    filepath   = data.get('filepath', '')
    start_page = data.get('start_page')
    end_page   = data.get('end_page')

    if not filepath or start_page is None or end_page is None:
        return jsonify({"error": "Missing required fields"}), 400

    try:
        start_page = int(start_page)
        end_page   = int(end_page)
    except (ValueError, TypeError):
        return jsonify({"error": "Invalid page numbers"}), 400

    # Normalize path separators and strip any leading /assets/ prefix
    filepath = filepath.replace("\\", "/")
    if filepath.startswith("assets/"):
        filepath = filepath[len("assets/"):]
    filepath = filepath.lstrip("/")

    input_path = os.path.join(current_app.root_path, 'resources', 'assets', filepath)
    print(f"[extract_pdf] resolved path: {input_path}")

    if not os.path.isfile(input_path):
        print(f"[extract_pdf] FILE NOT FOUND: {input_path}")
        return jsonify({"error": f"File not found: {filepath}"}), 404

    try:
        fd, output_path = tempfile.mkstemp(suffix=".pdf")
        os.close(fd)

        extract_pdf_pages(input_path, output_path, start_page, end_page)

        original_name = os.path.basename(input_path)
        base_name, _ = os.path.splitext(original_name)
        download_name = f"{base_name}_pages_{start_page}-{end_page}.pdf"

        return send_file(
            output_path,
            as_attachment=True,
            download_name=download_name,
            mimetype='application/pdf'
        )
    except ValueError as e:
        return jsonify({"error": str(e)}), 400
    except Exception as e:
        print(f"[extract_pdf] error: {e}")
        return jsonify({"error": "Failed to extract PDF pages"}), 500
