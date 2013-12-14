#!/bin/sh

var_framework_names=(
"RECoreGraphics"
"RECoreLocation"
"REFoundation"
"REMapKit"
"REQuartzCore"
"REUIKit"
"RFBridgeKeyLogger"
"RFFoundation"
"RFLibKern"
"RFMapKit"
"RFNetwork"
"RFObjC"
"RFQuartzCore"
"RFUIKit"
"RWObjC"
"RWSQLite"
"RWUUID"
)

var_separator="---"

var_framework_names2=(
"${var_separator}"
"RECoreGraphics"    #
"RECoreLocation"    #
"RFBridgeKeyLogger" #
"RFQuartzCore"      #
"RFObjC"            #
"RFLibKern"         #
"RWSQLite"          #
"RWObjC"            #

"${var_separator}"
"REFoundation"      # RWObjC
"REMapKit"          # RECoreLocation

"${var_separator}"
"REQuartzCore"      # REFoundation   RWObjC
"REUIKit"           # REFoundation   RWObjC
"RFMapKit"          # RECoreGraphics RECoreLocation REFoundation    REMapKit RWObjC
"RWUUID"            # REFoundation   RWObjC

"${var_separator}"
"RFFoundation"      # REFoundation   RWObjC         RWUUID

"${var_separator}"
"RFUIKit"           # REFoundation   RFFoundation   RWObjC          RWUUID

"${var_separator}"
"RFNetwork"         # REFoundation   RFFoundation   RFUIKit         RWUUID   RWObjC
)

var_used_paranel_command=1
var_preprocessor_definitions_enabled=1

var_root="${PWD}"
var_frameworks_dir="${var_root}/Frameworks"
var_build_dir="${var_root}/build"
#var_build_dir="/Volumes/MacOsXTemp/build"

# Remove the frameworkds folder.

if [ -d "${var_frameworks_dir}/" ]
then
	rm -rf "${var_frameworks_dir}/"

    if [ $? -ne 0 ]
    then
        echo "Can not remove the directory ${var_frameworks_dir}/."
        exit 1
    fi
fi

# Create the frameworks folder.

mkdir "${var_frameworks_dir}/"

if [ $? -ne 0 ]
then
    echo "Can not craete the directory ${var_frameworks_dir}/."
    exit 1
fi

# Remove the build folder.

if [ -d "${var_build_dir}/" ]
then
    rm -rf "${var_build_dir}/"

    if [ $? -ne 0 ]
    then
        echo "Can not remove the directory ${var_build_dir}/."
        exit 1
    fi
fi

# Remove the build folders.

for var_framework_name in "${var_framework_names2[@]}"
do
    var_framework_project_dir="${var_root}/${var_framework_name}"

# Remove the build folder.

    var_framework_build_dir="${var_framework_project_dir}/build"

    if [ "${var_used_paranel_command}" -eq 1 ]
    then
        rm -rf "${var_framework_build_dir}/" &
    else
        rm -rf "${var_framework_build_dir}/" &

        if [ $? -ne 0 ]
        then
            echo "Can not remove the directory ${var_framework_build_dir}/."
            exit 1
        fi
    fi
done

wait

# Build the all frameworks.

var_xcode_path="/Applications/Xcode.app"
var_xcode_bin_dir="${var_xcode_path}/Contents/Developer/usr/bin"

for var_framework_name in "${var_framework_names2[@]}"
do
    if [ "${var_framework_name}" == "${var_separator}" ]
    then
        wait
    else
        var_frameworks_framework_path="${var_external_frameworks_dir}/${var_framework_name}.framework"

        var_framework_project_dir="${var_root}/${var_framework_name}"

        var_framework_project_path="${var_framework_project_dir}/${var_framework_name}.xcodeproj"
        var_framework_project_target="${var_framework_name}"
        var_framework_project_configuration="Release"
        var_framework_project_sdk=""
        var_framework_project_action="build"
        var_framework_project_build_dir="${var_build_dir}"
        var_framework_project_build_root="${var_build_dir}"
        var_framework_project_obj_root="${var_build_dir}"
        var_framework_project_sym_root="${var_build_dir}"

        var_command_xcodebuild_build="${var_xcode_bin_dir}/xcodebuild"
        var_command_xcodebuild_build="${var_command_xcodebuild_build} -project ${var_framework_project_path}"
        var_command_xcodebuild_build="${var_command_xcodebuild_build} -target ${var_framework_project_target}"
        var_command_xcodebuild_build="${var_command_xcodebuild_build} -configuration ${var_framework_project_configuration}"
        var_command_xcodebuild_build="${var_command_xcodebuild_build} -sdk iphonesimulator"
        var_command_xcodebuild_build="${var_command_xcodebuild_build} build"
        var_command_xcodebuild_build="${var_command_xcodebuild_build} BUILD_DIR=${var_framework_project_build_dir}"
        var_command_xcodebuild_build="${var_command_xcodebuild_build} BUILD_ROOT=${var_framework_project_build_root}"
        var_command_xcodebuild_build="${var_command_xcodebuild_build} OBJROOT=${var_framework_project_obj_root}"
        var_command_xcodebuild_build="${var_command_xcodebuild_build} SYMROOT=${var_framework_project_sym_root}"
        var_command_xcodebuild_build="${var_command_xcodebuild_build} PR_MOVE_FRAMEWORK_INTO_PARENT_PATH=${var_frameworks_dir}"

        if [ "${var_preprocessor_definitions_enabled}" -eq 1 ]
        then
            var_command_xcodebuild_build="${var_command_xcodebuild_build} PR_USE_PREPROCESSOR_DEFINITIONS=1"
        fi

        echo ${var_command_xcodebuild_build}

        if [ "${var_used_paranel_command}" -eq 1 ]
        then
            ${var_command_xcodebuild_build} &
        else
            ${var_command_xcodebuild_build}

            if [ $? -ne 0 ]
            then
                echo "Can not build the framework ${var_framework_name}."
                exit 1
            fi
        fi
    fi
done

wait

echo "---FINISHED---"
