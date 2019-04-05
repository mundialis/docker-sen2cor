# Hello
process-1:
	docker-compose run sen2cor \
		L2A_Process /data/example/S2B_MSIL1C_20190331T000239_N0207_R030_T55GDQ_20190331T005814.SAFE \
			--resolution 20

process-2:
	docker-compose run sen2cor \
		L2A_Process /data/example/S2B_MSIL1C_20190331T000239_N0207_R030_T55GEN_20190331T005814.SAFE \
			--resolution 20

# T55GDN_20190110T000239_B04_10m
# T55GDN_20190110T0 S2B_OPER_MSI_ARD_TL_EPAE_20190110T011206_A009637_T55GDN_N02.07

# http://dea-public-data.s3-website-ap-southeast-2.amazonaws.com/?prefix=L2/sentinel-2-nrt/S2MSIARD/2019-01-10/S2B_OPER_MSI_ARD_TL_EPAE_20190110T011206_A009637_T55GDN_N02.07
process-3:

merge-1-pre:
	docker-compose run sen2cor \
		gdal_merge.py -init "0 0 0" -separate \
		-o /data/example/S2B_MSIL1C_20190331T000239_N0207_R030_T55GDQ_20190331T005814.tif \
		/data/example/S2B_MSIL1C_20190331T000239_N0207_R030_T55GDQ_20190331T005814.SAFE/GRANULE/L1C_T55GDQ_A010781_20190331T000821/IMG_DATA/T55GDQ_20190331T000239_B04.jp2 \
		/data/example/S2B_MSIL1C_20190331T000239_N0207_R030_T55GDQ_20190331T005814.SAFE/GRANULE/L1C_T55GDQ_A010781_20190331T000821/IMG_DATA/T55GDQ_20190331T000239_B03.jp2 \
		/data/example/S2B_MSIL1C_20190331T000239_N0207_R030_T55GDQ_20190331T005814.SAFE/GRANULE/L1C_T55GDQ_A010781_20190331T000821/IMG_DATA/T55GDQ_20190331T000239_B02.jp2

merge-1:
	docker-compose run sen2cor \
		gdal_merge.py -init "0 0 0" -separate \
		-o /data/example/S2B_MSIL2A_20190331T000239_N0207_R030_T55GDQ_20190331T005814-20m_RGB.tif \
		/data/example/S2B_MSIL2A_20190331T000239_N0207_R030_T55GDQ_20190331T005814.SAFE/GRANULE/L2A_T55GDQ_A010781_20190331T000821/IMG_DATA/R20m/T55GDQ_20190331T000239_B04_60m.jp2 \
		/data/example/S2B_MSIL2A_20190331T000239_N0207_R030_T55GDQ_20190331T005814.SAFE/GRANULE/L2A_T55GDQ_A010781_20190331T000821/IMG_DATA/R20m/T55GDQ_20190331T000239_B03_60m.jp2 \
		/data/example/S2B_MSIL2A_20190331T000239_N0207_R030_T55GDQ_20190331T005814.SAFE/GRANULE/L2A_T55GDQ_A010781_20190331T000821/IMG_DATA/R20m/T55GDQ_20190331T000239_B02_60m.jp2

merge-2:
	docker-compose run sen2cor \
		gdal_merge.py -init "0 0 0" -separate \
		-o /data/example/S2B_MSIL1C_20190331T000239_N0207_R030_T55GEN_20190331T005814-20m_RGB.tif \
		/data/example/S2B_MSIL2A_20190331T000239_N0207_R030_T55GEN_20190331T005814.SAFE/GRANULE/L2A_T55GEN_A010781_20190331T000821/IMG_DATA/R20m/T55GEN_20190331T000239_B04_20m.jp2 \
		/data/example/S2B_MSIL2A_20190331T000239_N0207_R030_T55GEN_20190331T005814.SAFE/GRANULE/L2A_T55GEN_A010781_20190331T000821/IMG_DATA/R20m/T55GEN_20190331T000239_B03_20m.jp2 \
		/data/example/S2B_MSIL2A_20190331T000239_N0207_R030_T55GEN_20190331T005814.SAFE/GRANULE/L2A_T55GEN_A010781_20190331T000821/IMG_DATA/R20m/T55GEN_20190331T000239_B02_20m.jp2

merge-2:
	docker-compose run sen2cor \
		gdal_merge.py -init "0 0 0" -separate \
		-o /data/example/S2B_MSIL1C_20190331T000239_N0207_R030_T55GEN_20190331T005814-20m_RGB.tif \
		/data/example/S2B_MSIL2A_20190331T000239_N0207_R030_T55GEN_20190331T005814.SAFE/GRANULE/L2A_T55GEN_A010781_20190331T000821/IMG_DATA/R20m/T55GEN_20190331T000239_B04_20m.jp2 \
		/data/example/S2B_MSIL2A_20190331T000239_N0207_R030_T55GEN_20190331T005814.SAFE/GRANULE/L2A_T55GEN_A010781_20190331T000821/IMG_DATA/R20m/T55GEN_20190331T000239_B03_20m.jp2 \
		/data/example/S2B_MSIL2A_20190331T000239_N0207_R030_T55GEN_20190331T005814.SAFE/GRANULE/L2A_T55GEN_A010781_20190331T000821/IMG_DATA/R20m/T55GEN_20190331T000239_B02_20m.jp2

merge-2-addo:
	docker-compose run sen2cor \
		gdaladdo -r average \
		/data/example/S2B_MSIL1C_20190331T000239_N0207_R030_T55GEN_20190331T005814-20m_RGB.tif \
		2 4 8 16