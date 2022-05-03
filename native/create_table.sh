#bq mkdef \
#--source_format=NEWLINE_DELIMITED_JSON \
#--noautodetect \
#subtle-champion-349012:here1.raw rawschema > rawdef
bq mk \
--schema rawschema \
--table here1.raw 

bq mk \
--schema partitionschema \
--time_partitioning_type=DAY \
--time_partitioning_field=partitionTime \
--table here1.partitioned

gsutil cp sampledata_partitioned.json gs://thechampishere/cloudruntestdrop/dt=2022050200

bq load --autodetect=false \
--schema rawschema \
--source_format=NEWLINE_DELIMITED_JSON \
here1.raw gs://thechampishere/cloudruntestdrop/dt=2022050200/sampledata_partitioned.json 
#subtle-champion-349012:here1.raw rawschema

bq query \
--use_legacy_sql=false \
--time_partitioning_field=partitionTime \
--time_partitioning_type=DAY \
--destination_table here1.partitioned \
"SELECT TIMESTAMP_MILLIS("timeInMillis") AS partitionTime, * FROM here1.raw WHERE true=true"

#--use_legacy_sql
#--allow_large_results=
