# SPDX-FileCopyrightText: Copyright The Zephyr Project Contributors
#
# SPDX-License-Identifier: Apache-2.0

# esp_blobs_link(<name> [<name> ...])
#
# Import lib<name>.a from the blob directory of the SoC series being built and
# link it, in the order given. No-op when building without blobs.
function(esp_blobs_link)
  if(CONFIG_BUILD_ONLY_NO_BLOBS)
    return()
  endif()

  set(blobs_dir ${ZEPHYR_HAL_ESPRESSIF_MODULE_DIR}/zephyr/blobs/lib/${CONFIG_SOC_SERIES})

  foreach(name ${ARGV})
    if(NOT TARGET esp_blob_${name})
      add_library(esp_blob_${name} STATIC IMPORTED GLOBAL)
      set_target_properties(esp_blob_${name} PROPERTIES
        IMPORTED_LOCATION ${blobs_dir}/lib${name}.a
      )
    endif()
    zephyr_link_libraries(esp_blob_${name})
  endforeach()
endfunction()
