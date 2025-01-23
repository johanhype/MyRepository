namespace: XML
flow:
  name: ValidateXML
  workflow:
    - validate:
        do:
          io.cloudslang.base.xml.validate:
            - xml_document: "C:\\OO220Labs\\XMLSample.xml"
            - xml_document_source: xmlPath
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
        x: 520
        'y': 280
        navigate:
          5719784e-8139-2121-9260-47030acabb36:
            targetId: b8561207-0d1d-4b1a-4e67-1137f13f2783
            port: SUCCESS
    results:
      SUCCESS:
        b8561207-0d1d-4b1a-4e67-1137f13f2783:
          x: 720
          'y': 320
