import os, re

events_dir = r"d:\Internship\demo1\app\resources\assets\admin\js\src\events"

def process_file(filepath):
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()

    if "FormValidation" in content:
        return
        
    # 1. Add import
    import_statement = 'import { FormValidation } from "../validations/form_validations.js";\n'
    
    # Insert after last import
    imports = list(re.finditer(r'^import .*;?\s*', content, re.MULTILINE))
    if imports:
        last_import = imports[-1]
        insert_pos = last_import.end()
        content = content[:insert_pos] + import_statement + content[insert_pos:]
    else:
        content = import_statement + content

    # 2. Extract form IDs
    create_form_id = None
    update_form_id = None
    
    m1 = re.search(r'async\s+create\s*\(\)\s*\{.*?[\'"](#?)(dataForm[^"\'\s]*)[\'"]', content, re.DOTALL)
    if m1:
        create_form_id = m1.group(2)
        if create_form_id.startswith('#'):
             create_form_id = create_form_id[1:]
    
    m2 = re.search(r'async\s+update\s*\(\)\s*\{.*?[\'"](#?)(dataForm[^"\'\s]*)[\'"]', content, re.DOTALL)
    if m2:
        update_form_id = m2.group(2)
        if update_form_id.startswith('#'):
             update_form_id = update_form_id[1:]
             
    if not create_form_id: create_form_id = "dataForm"
    if not update_form_id: update_form_id = "dataForm-update"

    # 3. Add to init
    init_code = f"""
        this.addValidation = new FormValidation("{create_form_id}");
        this.updateValidation = new FormValidation("{update_form_id}");
"""
    content = re.sub(r'(init\s*\(\)\s*\{)', r'\1' + init_code, content, count=1)

    # 4. Add to create
    create_code = """
        if (this.addValidation) {
            const result = this.addValidation.validateAll();
            if (!result.valid) {
                const firstError = Object.values(result.errors)[0];
                toast.error(firstError);
                return;
            }
        }
"""
    content = re.sub(r'(async\s+create\s*\(\)\s*\{)', r'\1' + create_code, content, count=1)

    # 5. Add to update
    update_code = """
        if (this.updateValidation) {
            const result = this.updateValidation.validateAll();
            if (!result.valid) {
                const firstError = Object.values(result.errors)[0];
                toast.error(firstError);
                return;
            }
        }
"""
    content = re.sub(r'(async\s+update\s*\(\)\s*\{)', r'\1' + update_code, content, count=1)

    with open(filepath, "w", encoding="utf-8") as f:
        f.write(content)

for filename in os.listdir(events_dir):
    if filename.endswith(".js") and filename not in ["user.events.js", "auth.event.js"]:
        process_file(os.path.join(events_dir, filename))
        print(f"Processed {filename}")
