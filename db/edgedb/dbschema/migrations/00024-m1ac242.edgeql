CREATE MIGRATION m1ac242we2h6a2hdssix5mnbtskxrefgi46vkyezisj7kne6hteenq
    ONTO m1uqqrr2bkp22u234amtu2zfa3eygoyomigeinong4bjnjimwgggea
{
  ALTER TYPE default::Chunk {
      ALTER PROPERTY database {
          USING (std::assert_single(.hold_database.name));
      };
  };
  ALTER TYPE default::Collection {
      CREATE MULTI LINK databases: default::DataBaseHub {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
  };
  ALTER TYPE default::DataBaseHub {
      DROP LINK chunks;
  };
  ALTER TYPE default::Prompt {
      CREATE MULTI LINK X_dashbord: default::Dashbord {
          ON TARGET DELETE ALLOW;
      };
  };
  ALTER TYPE default::Prompt {
      CREATE MULTI LINK X_file: default::File {
          ON TARGET DELETE ALLOW;
      };
  };
  ALTER TYPE default::Prompt {
      CREATE MULTI LINK X_folder: default::Folder {
          ON TARGET DELETE ALLOW;
      };
  };
  ALTER TYPE default::Prompt {
      CREATE MULTI LINK X_prompt: default::Prompt {
          ON TARGET DELETE ALLOW;
      };
  };
  ALTER TYPE default::Prompt {
      CREATE MULTI LINK X_tag: default::Tag {
          ON TARGET DELETE ALLOW;
      };
      ALTER PROPERTY metadata {
          SET TYPE std::json USING (<std::json>.metadata);
      };
  };
  ALTER TYPE default::Prompt {
      CREATE PROPERTY tags: std::str;
  };
  ALTER TYPE default::Prompt {
      ALTER PROPERTY type {
          RENAME TO name;
      };
  };
};
