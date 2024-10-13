CREATE MIGRATION m1oocxr63dcuhdxq3coyqjveayodru3r5n73isu4krgjtnkbfdxuoq
    ONTO m13rlcois3vhdl4uh5xuy5xxwqg6hx6zz7thkoxatgk2kszs2vt25q
{
  ALTER TYPE default::File {
      DROP LINK available_chunks;
  };
  ALTER TYPE default::Chunks_holder {
      DROP LINK chunks;
  };
  ALTER TYPE default::Chunks_holder {
      DROP PROPERTY description;
  };
  ALTER TYPE default::Chunks_holder {
      DROP PROPERTY emb_model;
  };
  ALTER TYPE default::Chunks_holder {
      DROP PROPERTY tags;
  };
  ALTER TYPE default::Chunks_holder {
      DROP PROPERTY type;
  };
  ALTER TYPE default::Chunks_holder RENAME TO default::Tag;
  ALTER TYPE default::Collection {
      CREATE MULTI LINK chats: default::Chat {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK files: default::File {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK folders: default::Folder {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK prompts: default::Prompt {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK tags: default::Tag {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
  };
  ALTER TYPE default::Dashbord {
      DROP LINK files;
  };
  ALTER TYPE default::Dashbord {
      DROP LINK folders;
  };
  ALTER TYPE default::Dashbord {
      CREATE MULTI LINK tags: default::Tag {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
  };
  ALTER TYPE default::Dashbord {
      CREATE PROPERTY description: std::str;
  };
  ALTER TYPE default::Dashbord {
      CREATE PROPERTY name: std::str;
  };
  ALTER TYPE default::File {
      CREATE MULTI LINK chunks: default::Chunk {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
  };
  ALTER TYPE default::Tag {
      CREATE MULTI LINK X_ref: default::Chunk {
          ON TARGET DELETE ALLOW;
      };
  };
  ALTER TYPE default::Tag {
      ALTER PROPERTY chunk_strategy {
          RENAME TO name;
      };
  };
};
