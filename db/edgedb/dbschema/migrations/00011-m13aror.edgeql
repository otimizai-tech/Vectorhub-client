CREATE MIGRATION m13arorkfwsjawvfvnrs6xdwwd4mi2om22nxbeqvt4oonj5huexr7q
    ONTO m1hqqgcpvlxqi67yllchuprggyfpbm2tias63nyto64zqon7wvgrna
{
  ALTER TYPE default::Folder {
      CREATE MULTI LINK folders: default::Folder {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
  };
};
