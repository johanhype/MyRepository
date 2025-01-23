namespace: Expresions
flow:
  name: parse_flow
  workflow:
    - parse_json_message:
        do:
          Expresions.parse_json_message:
            - json_string: |-
                ${'''
                    {
                        "@odata.etag": "W/CQAAABYAAABheQ7KwMzvS4oFgCBhLIn7AAB917kg",
                        "id": "AAMkAGZmMDcyNmZhLTIxNDMtNDViYS1hOGMxLTcxNmNiNTczZmY4ZABGAAAAAAAoHTw4bFOpT5xrx2riEMO0BwBheQ7KwMzvS4oFgCBhLIn7AAAAAAEMAABheQ7KwMzvS4oFgCBhLIn7AAB929siAAA=",
                        "subject": "FW: #VNRecord [ID]:73547/Friday, September 6, 2019/Arst.presales Arrived",
                        "body": {
                          "contentType": "html",
                          "content": "<html><head><style type='text/css' style='display:none'><!--p{margin-top:0;margin-bottom:0}--></style></head><body dir='ltr'><div style='font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)'></div></body></html>"
                        },
                        "sender": {
                          "emailAddress": {
                            "name": "Sheetal MP",
                            "address": "sheetalm@microfocus.com"
                          }
                        },
                        "from": {
                          "emailAddress": {
                            "name": "Sheetal MP",
                            "address": "sheetalm@microfocus.com"
                          }
                        },
                        "toRecipients": [
                          {
                            "emailAddress": {
                              "name": "BCC1@microfocus.com",
                              "address": "BCC1@microfocus.com"
                            }
                          },
                          {
                            "emailAddress": {
                              "name": "BCC2@microfocus.com",
                              "address": "BCC2@microfocus.com"
                            }
                          }
                        ],
                        "hasAttachments": true
                    }
                '''}
        navigate:
          - SUCCESS: SUCCESS
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      parse_json_message:
        x: 440
        'y': 240
        navigate:
          9d10538b-4ae9-e182-6879-50fa9f1a1173:
            targetId: 71866ffa-cdee-49f6-1bc1-5b65d0b032ec
            port: SUCCESS
    results:
      SUCCESS:
        71866ffa-cdee-49f6-1bc1-5b65d0b032ec:
          x: 640
          'y': 280
