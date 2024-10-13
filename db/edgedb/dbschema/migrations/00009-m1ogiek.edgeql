CREATE MIGRATION m1ogiek6iua6ttk65grpdwlrl5tmw2gbze5sgr7q3qp4e54p2qpjja
    ONTO m1blsfqraq3imnpy6zjxvp7hoc3g2qxoh3s62eovemkz3dzvd2dy7q
{
  CREATE TYPE default::Chat {
      CREATE PROPERTY history: std::str;
  };
  ALTER TYPE default::Dashbord {
      CREATE MULTI LINK chats: default::Chat {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      ALTER LINK files {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      ALTER LINK folders {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
  };
  ALTER TYPE default::Chunk {
      ALTER LINK X_ref {
          ON TARGET DELETE ALLOW;
      };
  };
  ALTER TYPE default::Chunks_holder {
      ALTER LINK chunks {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
  };
  ALTER TYPE default::Chunks_holder {
      ALTER PROPERTY metadata {
          RENAME TO tags;
      };
  };
  ALTER TYPE default::Chunks_holder {
      CREATE PROPERTY type: std::str;
  };
  ALTER TYPE default::Collection {
      ALTER LINK dashbord {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE DELETE SOURCE;
      };
  };
  CREATE TYPE default::Prompt {
      CREATE PROPERTY content: std::str;
      CREATE PROPERTY description: std::str;
      CREATE PROPERTY metadata: std::str;
      CREATE PROPERTY type: std::str;
  };
};
