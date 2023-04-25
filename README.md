# A Docker/Podman configuration for sen2cor

Sen2Cor processing chain information:
<https://elib.dlr.de/145360/1/Comparison_S2-L2A_core-and-user-product.pdf>

## Installation

Build this docker/podman image with:

```shell
docker build --file Dockerfile --tag sen2cor .
```

## sen2cor settings (file `L2A_GIPP.xml`)

Directory (path given within docker container) to auto-downloaded DEM into:

```XML
<DEM_Directory>/data/sen2cor_dem</DEM_Directory>
```

See [sen2cor manual](https://step.esa.int/thirdparties/sen2cor/2.11.0/docs/OMPC.TPZG.SUM.001%20-%20i1r0%20-%20Sen2Cor%202.11.00%20Configuration%20and%20User%20Manual.pdf):

_The third supported format (New Feature in Sen2Cor 2.10) is the Copernicus DEM. Please refer to the following link for more information:_
 _Copernicus DEM - GISCO - Eurostat (europa.eu):_ <https://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/elevation/copernicus-dem>
...
_For the new supported Copernicus DEM, for example at 90 m resolution, set in the `L2A_GIPP.xml` e.g.:_

```XML
<DEM_Directory>dem/CopernicusDEM</DEM_Directory>
<DEM_Reference>
https://prism-dem-open.copernicus.eu/pd-desk-open-access/prismDownload/COP-DEM_GLO-90-DGED__2021_1/
</DEM_Reference>
```

Background info on Copernicus DEM service:
<https://sentinels.copernicus.eu/web/sentinel/-/copernicus-dem-new-direct-data-download-access>


## Usage

Show sen2cor help text:

```shell
docker run -it --rm sen2cor L2A_Process --help
```

For a brief example, you first need to download a Sentinel-2 level 1C granule in the SAFE format, and place this unzipped in e.g. the `${HOME}/s2_L1C/` directory.

Example:
- unpack the S2-SAFE scene in `${HOME}/s2_L1C/`
- update as needed the `L2A_GIPP.xml` file to the directory in which docker/podman will be now started:

```shell
docker run -it --rm \
  --volume="$(pwd)/:/sen2cor_settings" --volume="${HOME}/s2_L1C/:/data/" sen2cor \
  L2A_Process --GIP_L2A /sen2cor_settings/L2A_GIPP.xml --resolution 10 \
  /data/S2A_MSIL1C_20210601T104021_N0300_R008_T32ULB_20210601T125922.SAFE
```

The resulting Sentinel-2 L2A scene (directory scene name changed to `N9999`) will be stored next to the L1C scene.

### Notes by Alex Leith in original repo (https://github.com/frontiersi/docker-sen2cor-example)
* If the run fails with an error like `[CRITICAL]  L2A_Config: 3181   Error in creating L2A User Product` then this may mean your granules don't have the `AUX_DATA` or `HTML` folders. The files I downloaded from CreoDIAS didn't have the `AUX_DATA` folders, so I created them, and it seems to work.
