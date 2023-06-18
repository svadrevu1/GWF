# URL: https://medium.com/geekculture/bulk-download-sentinel-1-sar-data-d180ec0bfac1

import asf_search as asf
import geopandas as gpd
from shapely.geometry import box
from datetime import date 

# Read Shapefile using Geopandas
gdf = gpd.read_file(path_to_shapefile)
# Extract the Bounding Box Coordinates
bounds = gdf.total_bounds
# Create GeoDataFrame of the Bounding Box 
gdf_bounds = gpd.GeoSeries([box(*bounds)])
# Get WKT Coordinates
wkt_aoi = gdf_bounds.to_wkt().values.tolist()[0]

results = asf.search(
    platform= asf.PLATFORM.SENTINEL1A,
    processingLevel=[asf.PRODUCT_TYPE.SLC],
    start = date(2017, 1, 1),
    end = date(2017, 12, 31),
    intersectsWith = wkt_aoi
    )
print(f'Total Images Found: {len(results)}')

# Save Metadata to a Dictionary
metadata = results.geojson()
session = asf.ASFSession().auth_with_creds(USERNAME, PASSWORD)
results.download(
     path = path_to_download_directory,
     session = session, 
     processes = 2)