[loadcsv var="f.pmask" src="csv/pmask.csv"]
[eval exp="sf.loading_text = f.pmask.map(v => v[0])"]
[return]
