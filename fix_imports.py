import os
import re

lib_dir = r"E:\final_voya\voya\lib"

# Old imports mapped to new ones
replacements = {
    # Auth - screens
    r"package:voya/features/driver_m/login/design_login_driver\.dart": r"package:voya/features/driver_m/auth/presentation/screens/driver_login_screen.dart",
    r"package:voya/features/driver_m/register/register_driver\.dart": r"package:voya/features/driver_m/auth/presentation/screens/driver_register_screen.dart",
    
    # Auth - widgets
    r"package:voya/features/driver_m/login/(add_image|add_image_car|auth_background|container_design_login|custom_app_bar|date_of_Birth|header|password|sign_in_up)\.dart": r"package:voya/features/driver_m/auth/presentation/widgets/login_widgets.dart",
    r"package:voya/features/driver_m/register/(login_button|login_form|register_header|signup_row)\.dart": r"package:voya/features/driver_m/auth/presentation/widgets/register_widgets.dart",
    
    # Home - logic
    r"package:voya/features/driver_m/home/cubit/add_trip_cubit\.dart": r"package:voya/features/driver_m/home/logic/add_trip_cubit.dart",
    r"package:voya/features/driver_m/home/cubit/add_trip_state\.dart": r"package:voya/features/driver_m/home/logic/add_trip_state.dart",
    r"../cubit/add_trip_cubit\.dart": r"../../logic/add_trip_cubit.dart",
    r"../cubit/add_trip_state\.dart": r"../../logic/add_trip_state.dart",
    r"\.\./home/cubit/add_trip_cubit\.dart": r"../logic/add_trip_cubit.dart",
    r"\.\./home/cubit/add_trip_state\.dart": r"../logic/add_trip_state.dart",
    r"package:voya/features/driver_m/home/cubit/": r"package:voya/features/driver_m/home/logic/",
    
    # Home - screens
    r"package:voya/features/driver_m/home/(bottom_nav|app_bar_screen|addtrip)\.dart": r"package:voya/features/driver_m/home/presentation/screens/\1.dart",
    r"package:voya/features/driver_m/home/trip/(add_new_trip|trip_form)\.dart": r"package:voya/features/driver_m/home/presentation/screens/\1.dart",

    # Home - widgets
    r"package:voya/features/driver_m/home/(completed_trip_card|waiting_trip_card|date_trime_helper)\.dart": r"package:voya/features/driver_m/home/presentation/widgets/home_widgets.dart",
    r"package:voya/features/driver_m/home/(seat_selector|trip_header|trip_input_home)\.dart": r"package:voya/features/driver_m/home/presentation/widgets/trip_widgets.dart",
    r"package:voya/features/driver_m/home/trip/(schedule_row|trip_section_title)\.dart": r"package:voya/features/driver_m/home/presentation/widgets/trip_widgets.dart",
    
    # Profile
    r"package:voya/features/driver_m/profile_driver/(profile_main|profile|car_info_screen|add_car)\.dart": r"package:voya/features/driver_m/profile_driver/presentation/screens/\1.dart",
    
    # Onboarding
    r"package:voya/features/driver_m/onboarding/(splash_screen|onboarding_page|roles_selection_page)\.dart": r"package:voya/features/driver_m/onboarding/presentation/screens/\1.dart",
    r"package:voya/features/driver_m/onboarding/(color_gradient|image_bus|role_selection_card)\.dart": r"package:voya/features/driver_m/onboarding/presentation/widgets/onboarding_widgets.dart",
}

for root, _, files in os.walk(lib_dir):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            new_content = content
            for old_pat, new_pat in replacements.items():
                new_content = re.sub(old_pat, new_pat, new_content)
                
            # deduplicate imports if we combined them (e.g. multiple widgets from same file)
            lines = new_content.split('\n')
            imports = set()
            out_lines = []
            for line in lines:
                if line.strip().startswith('import '):
                    if line in imports:
                        continue
                    imports.add(line)
                out_lines.append(line)
                
            if content != '\n'.join(out_lines):
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write('\n'.join(out_lines))

print("Imports fixed.")
