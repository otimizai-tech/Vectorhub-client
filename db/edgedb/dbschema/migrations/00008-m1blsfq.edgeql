CREATE MIGRATION m1blsfqraq3imnpy6zjxvp7hoc3g2qxoh3s62eovemkz3dzvd2dy7q
    ONTO m1utoohuhtnsa6t2gyyw5pbiucj7boekcgjstgqjum3zoitfgdnv4q
{
  ALTER TYPE default::File {
      ALTER LINK available_chunks {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
  };
};
