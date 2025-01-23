namespace: VMHealth
flow:
  name: vm_health_check
  inputs:
    - ipaddress: 172.16.11.26
    - username: root
    - password: opentext
  workflow:
    - free_stat:
        do:
          io.cloudslang.base.ssh.ssh_flow:
            - host: '${ipaddress}'
            - command: free
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        publish:
          - standard_out
        navigate:
          - SUCCESS: vm_stat
          - FAILURE: on_failure
    - vm_stat:
        do:
          io.cloudslang.base.ssh.ssh_flow:
            - host: '${ipaddress}'
            - command: vmstat
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        publish:
          - vmstat_value: '${standard_out}'
        navigate:
          - SUCCESS: disk_stat
          - FAILURE: on_failure
    - disk_stat:
        do:
          io.cloudslang.base.ssh.ssh_flow:
            - host: '${ipaddress}'
            - command: df
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        publish:
          - standard_out
        navigate:
          - SUCCESS: write_log
          - FAILURE: on_failure
    - write_log:
        do:
          io.cloudslang.base.ssh.ssh_flow:
            - host: '${ipaddress}'
            - command: |-
                rm -rf /tmp/vmhealth && mkdir /tmp/vmhealth && {
                    echo "$free_value" >> /tmp/vmhealth/vmhealth.log
                    echo "$vmstat_value" >> /tmp/vmhealth/vmhealth.log
                    echo "$disk_value" >> /tmp/vmhealth/vmhealth.log

                }
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        publish: []
        navigate:
          - SUCCESS: send_mail
          - FAILURE: on_failure
    - send_mail:
        do:
          io.cloudslang.base.mail.send_mail:
            - hostname: localhost
            - port: '25'
            - from: sheetal@ot.com
            - to: stephen@ot.com
            - subject: VM Health Report
            - body: |-
                ${'''Hello All,


                Please find the Health report for Virtual Machine!

                Free Space:
                $s

                vmstat Details:
                %s

                Disk Details:
                %s

                Thank you
                ''' %(free_value, vmstat_value, disk_value)}
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      free_stat:
        x: 200
        'y': 120
      vm_stat:
        x: 280
        'y': 240
      disk_stat:
        x: 400
        'y': 280
      write_log:
        x: 480
        'y': 160
      send_mail:
        x: 640
        'y': 160
        navigate:
          2b443590-4bbe-3b99-9f27-4ca3734faa70:
            targetId: ca4a9dd3-872a-d852-a482-84cebac46018
            port: SUCCESS
    results:
      SUCCESS:
        ca4a9dd3-872a-d852-a482-84cebac46018:
          x: 880
          'y': 120
