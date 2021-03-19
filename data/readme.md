# Data
Store all of your research data. It is recommended that raw data not be altered once downloaded or collected. Maintaining a separate raw data file facilitates reproducibility be preserving a common point of analytical origin. It is similarly recommended that whenever possible data processing, transformation, or manipulation be completed with code as this practice facilitates re-analysis and reduces opportunities of confusion.

Complete the [data_metadata.csv](data_metadata.csv) file indexing each data file, including the fields:

- path
- name
- format
- sources, where sources may be the original data provider for raw data, or the raw files from which data was derived for cleaned data. List multiple sources with a semicolon separator.
- metadata: files stored in `data/metadata` folder. List each metadata document associated with each data file. List multiple metadata files with semicolon separators.

Researchers are strongly encouraged to include additional metadata alongside raw data sources.
