bq mkdef  --source_format=NEWLINE_DELIMITED_JSON \
--noautodetect \
--hive_partitioning_mode=CUSTOM \
--hive_partitioning_source_uri_prefix=gs://thechampishere/cloudruntestdrop/{dt:STRING} \
"gs://thechampishere/cloudruntestdrop/*" externalschema > external_table_def
bq mk \
--table \
--external_table_definition=external_table_def \
subtle-champion-349012:here1.external

gsutil cp sampledata_external.json gs://thechampishere/cloudruntestdrop/dt=2022050201/some_data.json

#[edward@localhost external]$ bq query --use_legacy_sql=false "select * from here1.external"
#+--------------+------------+
#|    afield    |     dt     |
#+--------------+------------+
#| avalue       | 2022050200 |
#| anothervalue | 2022050200 |
#| avalue       | 2022050201 |
#| anothervalue | 2022050201 |
#+--------------+------------+

