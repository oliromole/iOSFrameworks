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
"REFoundation"      #
"RFBridgeKeyLogger" #
"RFQuartzCore"      #
"RFObjC"            #
"RWSQLite"          #
"RWObjC"            #

"${var_separator}"
"REMapKit"          # RECoreLocation
"REQuartzCore"      # REFoundation
"REUIKit"           # REFoundation
"RFLibKern"         # RFBridgeKeyLogger
"RWUUID"            # REFoundation

"${var_separator}"
"RFFoundation"      # REFoundation      RWUUID
"RFMapKit"          # RECoreGraphics    RECoreLocation REFoundation REMapKit

"${var_separator}"
"RFUIKit"           # REFoundation      REUIKit        RFFoundation RWUUID

"${var_separator}"
"RFNetwork"         # REFoundation      RFFoundation   RFUIKit      RWUUID
)

var_sdks=(
"iphonesimulator"
"iphoneos"
)

var_used_paranel_command=1
var_preprocessor_definitions_enabled=1

var_root="${PWD}"
var_frameworks_dir="${var_root}/Frameworks"
var_build_dir="${var_root}/build"
#var_build_dir="/Volumes/MacOsXTemp/build"

# Functions

fun_copy_directory()
{
    var_source_dir=$1
    var_distination_dir=$2

    if [ -z "${var_source_dir}" ]
    then
        echo "Can not copy the directory ${var_source_dir}/ into the directory ${var_distination_dir}/."
        exit 1
    fi

    if [ -z "${var_distination_dir}" ]
    then
        echo "Can not copy the directory ${var_source_dir}/ into the directory ${var_distination_dir}/."
        exit 1
    fi

    if [ ! -d "${var_source_dir}" ]
    then
        echo "Can not copy the directory ${var_source_dir}/ into the directory ${var_distination_dir}/. The directory ${var_source_dir} is not exist."
        exit 1
    fi

    var_command_cp_copy="cp -R"
    var_command_cp_copy="${var_command_cp_copy} ${var_source_dir}/"
    var_command_cp_copy="${var_command_cp_copy} ${var_distination_dir}/"

    echo "${var_command_cp_copy}"

    ${var_command_cp_copy}

    if [ $? -ne 0 ]
    then
        echo "Can not copy the directory ${var_source_dir}/ into the directory ${var_distination_dir}/."
        exit 1
    fi
}

fun_create_directory()
{
    var_dir=$1

    if [ -z "${var_dir}" ]
    then
        echo "Can not create the directory ${var_dir}/."
        exit 1
    fi

    var_command_mkdir_create="mkdir"
    var_command_mkdir_create="${var_command_mkdir_create} ${var_dir}/"

    echo "${var_command_mkdir_create}"

    ${var_command_mkdir_create}

    if [ $? -ne 0 ]
    then
        echo "Can not create the directory ${var_dir}/."
        exit 1
    fi
}

fun_move_directory()
{
    var_source_dir=$1
    var_distination_dir=$2

    if [ -z "${var_source_dir}" ]
    then
        echo "Can not move the directory ${var_source_dir}/ into the directory ${var_distination_dir}/."
        exit 1
    fi

    if [ -z "${var_distination_dir}" ]
    then
        echo "Can not move the directory ${var_source_dir}/ into the directory ${var_distination_dir}/."
        exit 1
    fi

    var_command_mv_move="mv"
    var_command_mv_move="${var_command_mv_move} ${var_source_dir}/"
    var_command_mv_move="${var_command_mv_move} ${var_distination_dir}/"

    echo "${var_command_mv_move}"

    ${var_command_mv_move}

    if [ $? -ne 0 ]
    then
        echo "Can not move the directory ${var_source_dir}/ into the directory ${var_distination_dir}/."
        exit 1
    fi
}

fun_remove_directory()
{
    var_dir=$1

    if [ -z "${var_dir}" ]
    then
        echo "Can not remove the directory ${var_dir}/."
        exit 1
    fi

    if [ -d "${var_dir}/" ]
    then
        var_command_rm_remove="rm -rf"
        var_command_rm_remove="${var_command_rm_remove} ${var_dir}/"

        echo "${var_command_rm_remove}"

        ${var_command_rm_remove}

        if [ $? -ne 0 ]
        then
            echo "Can not remove the directory ${var_dir}/."
            exit 1
        fi
    fi
}

fun_run_command()
{
    var_command=$1

    echo "${var_command}"

    ${var_command}

    if [ $? -ne 0 ]
    then
        echo "Command did not return 0. Command: ${var_command}"
        exit 1
    fi
}

# Remove the frameworkds folder.

fun_remove_directory "${var_frameworks_dir}"

# Create the frameworks folder.

fun_create_directory "${var_frameworks_dir}"

# Remove and Create the frameworks folders for the sdks.

for var_sdk in "${var_sdks[@]}"
do
    var_sdk_frameworks_dir="${var_frameworks_dir}-${var_sdk}"

    fun_remove_directory "${var_sdk_frameworks_dir}"

    fun_create_directory "${var_sdk_frameworks_dir}"
done

# Remove the build folder.

fun_remove_directory "${var_build_dir}"

# Remove the build folders.

for var_framework_name in "${var_framework_names2[@]}"
do
    var_framework_project_dir="${var_root}/${var_framework_name}"

# Remove the build folder.

    var_framework_build_dir="${var_framework_project_dir}/build"

    if [ "${var_used_paranel_command}" -eq 1 ]
    then
        fun_remove_directory "${var_framework_build_dir}/" &
    else
        fun_remove_directory "${var_framework_build_dir}/"
    fi
done

wait

# Build the all frameworks.

var_xcode_path="/Applications/Xcode.app"
var_xcode_bin_dir="${var_xcode_path}/Contents/Developer/usr/bin"

for var_sdk in "${var_sdks[@]}"
do
    for var_framework_name in "${var_framework_names2[@]}"
    do
        if [ "${var_framework_name}" == "${var_separator}" ]
        then
            wait
        else
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
            var_command_xcodebuild_build="${var_command_xcodebuild_build} -sdk ${var_sdk}"
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

            if [ "${var_used_paranel_command}" -eq 1 ]
            then
                fun_run_command "${var_command_xcodebuild_build}" &
            else
                fun_run_command "${var_command_xcodebuild_build}"
            fi
        fi
    done

    wait

    var_sdk_frameworks_dir="${var_frameworks_dir}-${var_sdk}"

    for var_framework_name in "${var_framework_names2[@]}"
    do
        if [ "${var_framework_name}" == "${var_separator}" ]
        then
            continue
        fi

        var_frameworks_framework_path="${var_frameworks_dir}/${var_framework_name}.framework"

        var_sdk_frameworks_framework_path="${var_sdk_frameworks_dir}/${var_framework_name}.framework"

        if [ "${var_used_paranel_command}" -eq 1 ]
        then
            fun_move_directory "${var_frameworks_framework_path}" "${var_sdk_frameworks_framework_path}" &
        else
            fun_move_directory "${var_frameworks_framework_path}" "${var_sdk_frameworks_framework_path}"
        fi
    done

    wait
done

wait

# Merge the SDK frameworks

for var_framework_name in "${var_framework_names2[@]}"
do
    if [ "${var_framework_name}" == "${var_separator}" ]
    then
        continue
    fi

    var_frameworks_framework_path="${var_frameworks_dir}/${var_framework_name}.framework"
    var_frameworks_framework_headers_dir="${var_frameworks_framework_path}/Headers"
    var_frameworks_framework_private_headers_dir="${var_frameworks_framework_path}/PrivateHeaders"
    var_frameworks_framework_library_path="${var_frameworks_framework_path}/${var_framework_name}"

    fun_create_directory "${var_frameworks_framework_path}"

    for var_sdk in "${var_sdks[@]}"
    do
        var_sdk_frameworks_dir="${var_frameworks_dir}-${var_sdk}"
        var_sdk_frameworks_framework_path="${var_sdk_frameworks_dir}/${var_framework_name}.framework"
        var_sdk_frameworks_framework_headers_dir="${var_sdk_frameworks_framework_path}/Headers"

        if [ -d "${var_sdk_frameworks_framework_headers_dir}/" ]
        then
            if [ "${var_used_paranel_command}" -eq 1 ]
            then
                fun_copy_directory "${var_sdk_frameworks_framework_headers_dir}" "${var_frameworks_framework_headers_dir}" &
            else
                fun_copy_directory "${var_sdk_frameworks_framework_headers_dir}" "${var_frameworks_framework_headers_dir}"
            fi
        fi

        break
    done

    for var_sdk in "${var_sdks[@]}"
    do
        var_sdk_frameworks_dir="${var_frameworks_dir}-${var_sdk}"
        var_sdk_frameworks_framework_path="${var_sdk_frameworks_dir}/${var_framework_name}.framework"
        var_sdk_frameworks_framework_private_headers_dir="${var_sdk_frameworks_framework_path}/PrivateHeaders"

        if [ -d "${var_sdk_frameworks_framework_private_headers_dir}/" ]
        then
            if [ "${var_used_paranel_command}" -eq 1 ]
            then
                fun_copy_directory "${var_sdk_frameworks_framework_private_headers_dir}" "${var_frameworks_framework_private_headers_dir}" &
            else
                fun_copy_directory "${var_sdk_frameworks_framework_private_headers_dir}" "${var_frameworks_framework_private_headers_dir}"
            fi
        fi

        break
    done

    var_command_lipo_create="lipo"
    var_command_lipo_create="${var_command_lipo_create} -create"

    for var_sdk in "${var_sdks[@]}"
    do
        var_sdk_frameworks_dir="${var_frameworks_dir}-${var_sdk}"
        var_sdk_frameworks_framework_path="${var_sdk_frameworks_dir}/${var_framework_name}.framework"
        var_sdk_frameworks_framework_library_path="${var_sdk_frameworks_framework_path}/${var_framework_name}"

        var_command_lipo_create="${var_command_lipo_create} ${var_sdk_frameworks_framework_library_path}"
    done

    var_command_lipo_create="${var_command_lipo_create} -output ${var_frameworks_framework_library_path}"

    if [ "${var_used_paranel_command}" -eq 1 ]
    then
        fun_run_command "${var_command_lipo_create}" &
    else
        fun_run_command "${var_command_lipo_create}"
    fi
done

wait

# Print the frameworks info

echo "Frameworks:"

for var_framework_name in "${var_framework_names2[@]}"
do
    if [ "${var_framework_name}" == "${var_separator}" ]
    then
        continue
    fi

    echo "${var_framework_name}"

    var_frameworks_framework_path="${var_frameworks_dir}/${var_framework_name}.framework"
    var_frameworks_framework_library_path="${var_frameworks_framework_path}/${var_framework_name}"

    var_command_lipo_detaile_info="xcrun -sdk iphoneos lipo -detailed_info"
    var_command_lipo_detaile_info="${var_command_lipo_detaile_info} ${var_frameworks_framework_library_path}"

    ${var_command_lipo_detaile_info} | grep "architecture"
done

# Finish

var_finished=1

for var_framework_name in "${var_framework_names2[@]}"
do
    if [ "${var_framework_name}" == "${var_separator}" ]
    then
        continue
    fi

    var_frameworks_framework_path="${var_frameworks_dir}/${var_framework_name}.framework"
    var_frameworks_framework_library_path="${var_frameworks_framework_path}/${var_framework_name}"

    if [ ! -f "${var_frameworks_framework_library_path}" ]
    then
        var_finished=0
        echo "Failed: ${var_framework_name}"
    fi
done

if [ "${var_finished}" -eq 1 ]
then
    echo "---FINISHED---"

    exit 0
else
    echo "---FIAILD---"

    exit 1
fi
