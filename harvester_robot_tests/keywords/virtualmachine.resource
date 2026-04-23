*** Settings ***
Documentation    VM Keywords
Resource         variables.resource
Resource         common.resource
Resource         image.resource
Library          ../libs/keywords/vm_keywords.py

*** Keywords ***
List VMs by prefix
    [Arguments]    ${prefix}    ${namespace}=default
    [Documentation]    List VMs whose names start with the given prefix
    ${vms}=    list vms    namespace=${namespace}    name_prefix=${prefix}
    RETURN    ${vms}

VM is created
    [Arguments]    ${vm_name}    &{config}
    [Documentation]    Create a virtual machine with provided name
    create vm    ${vm_name}    &{config}

VM is deleted
    [Arguments]    ${vm_name}
    [Documentation]    Delete a VM
    delete vm    ${vm_name}

VM is started
    [Arguments]    ${vm_name}
    [Documentation]    Start a VM
    start vm    ${vm_name}

VM is stopped
    [Arguments]    ${vm_name}
    [Documentation]    Stop a VM
    stop vm    ${vm_name}

VM should be running
    [Arguments]    ${vm_name}
    [Documentation]    Wait for VM to reach running state
    wait for vm running    ${vm_name}

VM should be stopped
    [Arguments]    ${vm_name}
    [Documentation]    Wait for VM to stop
    wait for vm stopped    ${vm_name}

VM should be deleted
    [Arguments]    ${vm_name}
    [Documentation]    Wait for VM to be deleted
    wait for vm deleted    ${vm_name}

VM should have IP addresses
    [Arguments]    ${vm_name}    ${networks}
    [Documentation]    Wait for VM to obtain IP addresses
    wait for vm ip addresses    ${vm_name}    ${networks}

Data is written to VM
    [Arguments]    ${vm_name}    ${data_size_mb}=100
    [Documentation]    Write data to VM and return checksum
    ${checksum}=    write vm data    ${vm_name}    ${data_size_mb}
    RETURN    ${checksum}

Get VM data checksum
    [Arguments]    ${vm_name}
    [Documentation]    Get checksum of data in VM
    ${checksum}=    get vm data checksum    ${vm_name}
    RETURN    ${checksum}

Image is available for VM creation
    [Arguments]    ${image_name}    ${image_url}
    [Documentation]    Create an image from URL (delegates to Image module).
    Image - Create image from url with name    ${image_name}    ${image_url}
    Image - Wait for image downloaded by name    ${image_name}
