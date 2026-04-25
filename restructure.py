import os
import shutil
import re

base_dir = r"E:\final_voya\voya\lib\features\driver_m"

def ensure_dir(path):
    os.makedirs(path, exist_ok=True)

def parse_dart_file(filepath):
    imports = set()
    code = []
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
        
    for line in lines:
        if line.strip().startswith('import ') or line.strip().startswith('part '):
            imports.add(line.strip())
        else:
            code.append(line)
            
    return imports, ''.join(code)

def combine_dart_files(files, out_path):
    all_imports = set()
    all_code = []
    
    for f in files:
        if os.path.exists(f):
            imports, code = parse_dart_file(f)
            all_imports.update(imports)
            all_code.append(f"// --- from {os.path.basename(f)} ---\n")
            all_code.append(code)
            all_code.append("\n")
            
    with open(out_path, 'w', encoding='utf-8') as out:
        for imp in sorted(all_imports):
            out.write(imp + '\n')
        out.write('\n')
        out.write(''.join(all_code))
        
    for f in files:
        if os.path.exists(f):
            os.remove(f)

# 1. Auth Module
ensure_dir(os.path.join(base_dir, "auth", "presentation", "screens"))
ensure_dir(os.path.join(base_dir, "auth", "presentation", "widgets"))

# Screens
login_dir = os.path.join(base_dir, "login")
register_dir = os.path.join(base_dir, "register")

if os.path.exists(os.path.join(login_dir, "design_login_driver.dart")):
    shutil.move(os.path.join(login_dir, "design_login_driver.dart"), 
                os.path.join(base_dir, "auth", "presentation", "screens", "driver_login_screen.dart"))

if os.path.exists(os.path.join(register_dir, "register_driver.dart")):
    shutil.move(os.path.join(register_dir, "register_driver.dart"), 
                os.path.join(base_dir, "auth", "presentation", "screens", "driver_register_screen.dart"))

# Login widgets
login_widgets = [
    "add_image.dart", "add_image_car.dart", "auth_background.dart", 
    "container_design_login.dart", "custom_app_bar.dart", "date_of_Birth.dart", 
    "header.dart", "password.dart", "sign_in_up.dart"
]
combine_dart_files([os.path.join(login_dir, w) for w in login_widgets], 
                   os.path.join(base_dir, "auth", "presentation", "widgets", "login_widgets.dart"))

# Register widgets
register_widgets = [
    "login_button.dart", "login_form.dart", "register_header.dart", "signup_row.dart"
]
combine_dart_files([os.path.join(register_dir, w) for w in register_widgets], 
                   os.path.join(base_dir, "auth", "presentation", "widgets", "register_widgets.dart"))

# Clean up login/register dirs
if os.path.exists(login_dir) and not os.listdir(login_dir):
    os.rmdir(login_dir)
if os.path.exists(register_dir) and not os.listdir(register_dir):
    os.rmdir(register_dir)

# 2. Home Module
home_dir = os.path.join(base_dir, "home")
ensure_dir(os.path.join(home_dir, "logic"))
ensure_dir(os.path.join(home_dir, "presentation", "screens"))
ensure_dir(os.path.join(home_dir, "presentation", "widgets"))

# Logic
if os.path.exists(os.path.join(home_dir, "cubit", "add_trip_cubit.dart")):
    shutil.move(os.path.join(home_dir, "cubit", "add_trip_cubit.dart"), 
                os.path.join(home_dir, "logic", "add_trip_cubit.dart"))
if os.path.exists(os.path.join(home_dir, "cubit", "add_trip_state.dart")):
    shutil.move(os.path.join(home_dir, "cubit", "add_trip_state.dart"), 
                os.path.join(home_dir, "logic", "add_trip_state.dart"))
if os.path.exists(os.path.join(home_dir, "cubit")):
    os.rmdir(os.path.join(home_dir, "cubit"))

# Screens
for s in ["bottom_nav.dart", "app_bar_screen.dart", "addtrip.dart"]:
    if os.path.exists(os.path.join(home_dir, s)):
        shutil.move(os.path.join(home_dir, s), os.path.join(home_dir, "presentation", "screens", s))
for s in ["add_new_trip.dart", "trip_form.dart"]:
    if os.path.exists(os.path.join(home_dir, "trip", s)):
        shutil.move(os.path.join(home_dir, "trip", s), os.path.join(home_dir, "presentation", "screens", s))

# Widgets
home_widgets = ["completed_trip_card.dart", "waiting_trip_card.dart", "date_trime_helper.dart"]
combine_dart_files([os.path.join(home_dir, w) for w in home_widgets], 
                   os.path.join(home_dir, "presentation", "widgets", "home_widgets.dart"))

trip_widgets = ["seat_selector.dart", "trip_header.dart", "trip_input_home.dart", "schedule_row.dart", "trip_section_title.dart"]
trip_widgets_paths = [os.path.join(home_dir, w) for w in trip_widgets[:3]] + [os.path.join(home_dir, "trip", w) for w in trip_widgets[3:]]
combine_dart_files(trip_widgets_paths, os.path.join(home_dir, "presentation", "widgets", "trip_widgets.dart"))

if os.path.exists(os.path.join(home_dir, "trip")) and not os.listdir(os.path.join(home_dir, "trip")):
    os.rmdir(os.path.join(home_dir, "trip"))

# 3. Profile Module
profile_dir = os.path.join(base_dir, "profile_driver")
ensure_dir(os.path.join(profile_dir, "presentation", "screens"))
for s in ["profile_main.dart", "profile.dart", "car_info_screen.dart", "add_car.dart"]:
    if os.path.exists(os.path.join(profile_dir, s)):
        shutil.move(os.path.join(profile_dir, s), os.path.join(profile_dir, "presentation", "screens", s))

# 4. Onboarding Module
onboarding_dir = os.path.join(base_dir, "onboarding")
ensure_dir(os.path.join(onboarding_dir, "presentation", "screens"))
ensure_dir(os.path.join(onboarding_dir, "presentation", "widgets"))

for s in ["splash_screen.dart", "onboarding_page.dart", "roles_selection_page.dart"]:
    if os.path.exists(os.path.join(onboarding_dir, s)):
        shutil.move(os.path.join(onboarding_dir, s), os.path.join(onboarding_dir, "presentation", "screens", s))

onboarding_widgets = ["color_gradient.dart", "image_bus.dart", "role_selection_card.dart"]
combine_dart_files([os.path.join(onboarding_dir, w) for w in onboarding_widgets], 
                   os.path.join(onboarding_dir, "presentation", "widgets", "onboarding_widgets.dart"))

print("Restructuring done.")
