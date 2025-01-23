namespace: XML
flow:
  name: TransformXML
  workflow:
    - validate:
        do:
          io.cloudslang.base.xml.validate:
            - xml_document: "C:\\OO220Labs\\books.xml"
            - xml_document_source: xmlPath
        publish:
          - validated_xml_document: '${xml_document}'
        navigate:
          - SUCCESS: convert_to_html
          - FAILURE: on_failure
    - convert_to_html:
        do:
          io.cloudslang.base.xml.apply_xsl_transformation:
            - xml_document: '${validated_xml_document}'
            - xsl_template: "C:\\OO220Labs\\books.xsl"
            - output_file: "C:\\OO220Labs\\books.html"
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      validate:
        x: 360
        'y': 160
      convert_to_html:
        x: 680
        'y': 120
        navigate:
          6ef01f7a-8190-e689-8638-3c1f340a80c7:
            targetId: b8561207-0d1d-4b1a-4e67-1137f13f2783
            port: SUCCESS
    results:
      SUCCESS:
        b8561207-0d1d-4b1a-4e67-1137f13f2783:
          x: 720
          'y': 320
