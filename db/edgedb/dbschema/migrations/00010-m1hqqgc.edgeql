CREATE MIGRATION m1hqqgcpvlxqi67yllchuprggyfpbm2tias63nyto64zqon7wvgrna
    ONTO m1ogiek6iua6ttk65grpdwlrl5tmw2gbze5sgr7q3qp4e54p2qpjja
{
  ALTER TYPE default::Folder {
      CREATE MULTI LINK files: default::File {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
  };
};
