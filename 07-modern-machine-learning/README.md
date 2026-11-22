# Modern Machine Learning Models

**Unit:** DTSC71-306 Modern Machine Learning Models
**Tools:** Python, scikit-learn, pandas, Plotly, Google Colab

## a2-timber-species-clustering

Unsupervised clustering for a biosecurity and customs use case: pre-screening timber shipments by species so that low-risk specimens clear automatically and ambiguous ones go to a human expert.

- **Data:** 293,829 wood texture samples across 58 families, described by 7 pre-computed feature extraction methods. I narrowed this to three families with enough samples and enough taxonomic diversity (18,530 samples), after a test on the five biggest families gave near-random clusters (ARI 0.15).
- **Method:** 105 configurations (7 feature methods and 11 algorithms, plus PCA variants), scored on ARI, silhouette, homogeneity, completeness and run time.
- **Findings:**
  - Cosine distance beat Euclidean (ARI 0.528 against 0.415), so species identity sits in the direction of the texture pattern, not its magnitude.
  - All internal metrics picked k=2, although there are three real families. Internal scores alone would have led to a biologically wrong model.
  - The screening approach classifies 83.4% of specimens correctly. Vochysiaceae reaches 90.2%, while Lecythidaceae has a 26.3% miss rate and needs human verification.

Files: `timber_species_clustering.ipynb` (code with outputs) and `Report.docx` (the written report).

## a3-migration-dashboard

An interactive storytelling dashboard on 34 years of UN migration data (1990 to 2024), built with Plotly and ipywidgets, using UN DESA migrant stock data and World Bank refugee data for 232 countries.

It has more than 15 interactive views: choropleth maps, an animated time series, a regional sunburst and treemap, a corridor chart, a country comparison tool and a Brazil and Australia case study. Headline findings include 304 million people living outside their birth country, ten countries hosting about 48% of all migrants, and 29 million more migrants between 2020 and 2024.

Files: `migration_dashboard.ipynb` (the notebook, 66 code cells) and `Dashboard_Guide.pdf` (the user guide I wrote for it).

To run it, open the notebook in Google Colab and download the three UN DESA International Migrant Stock files named in Section 2. When the upload window opens, select all 3 at once. The notebook checks that all three are there, says which one is missing or wrong, and asks again. The refugee data is fetched from the World Bank API, with a built-in fallback if that is unavailable.

## Notes

- Datasets are not included. The wood texture features and the UN files come from the course and public sources.
- The saved copy of the migration notebook lost its line breaks and the indentation of one cell. I restored the formatting without changing any code, apart from rewriting the file upload step in Section 2, then ran all 66 cells end to end on the real UN 2024 files. Every cell runs and renders its charts, and the headline numbers match my guide: 304 million migrants worldwide, 52 million in the USA, 8.1 million foreign-born in Australia, 2.2 million Brazilians abroad and +29 million since 2020. I checked the numbers, not the charts visually.
