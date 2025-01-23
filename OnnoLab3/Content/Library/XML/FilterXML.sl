namespace: XML
flow:
  name: FilterXML
  workflow:
    - validate:
        do:
          io.cloudslang.base.xml.validate:
            - xml_document: "C:\\OO220Labs\\XMLSample.xml"
            - xml_document_source: xmlPath
        publish:
          - validated_xml_document: '${xml_document}'
        navigate:
          - SUCCESS: xpath_query
          - FAILURE: on_failure
    - xpath_query:
        do:
          io.cloudslang.base.xml.xpath_query:
            - xml_document: '${validated_xml_document}'
            - xml_document_source: xmlPath
            - xpath_query:
                prompt:
                  type: text
            - query_type: null
            - query_type_1: xpath_query
            - query_type_2: xpath_query
        publish:
          - selected_value
        navigate:
          - SUCCESS: Display_Message
          - FAILURE: on_failure
    - Display_Message:
        do_external:
          434e6fa2-26bc-4e84-9e1f-0aa6946cf920:
            - message: '${selected_value}'
        navigate:
          - success: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      validate:
        x: 520
        'y': 280
      xpath_query:
        x: 680
        'y': 160
      Display_Message:
        x: 840
        'y': 160
        navigate:
          ab21e0b3-3b97-513c-b6d2-7647b2da5754:
            targetId: b8561207-0d1d-4b1a-4e67-1137f13f2783
            port: success
    results:
      SUCCESS:
        b8561207-0d1d-4b1a-4e67-1137f13f2783:
          x: 720
          'y': 320
