       SELECT ssw.stopword, slg.name
      FROM sys.fulltext_system_stopwords ssw
      JOIN sys.fulltext_languages slg
      ON slg.lcid = ssw.language_id
      WHERE slg.lcid =1033