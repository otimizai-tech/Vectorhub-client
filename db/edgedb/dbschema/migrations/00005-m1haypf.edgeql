CREATE MIGRATION m1haypfgpzhrlz5b6xrwtag67lqjqmndyhqqdsgl5m46rcndzuqf3a
    ONTO m1xaq3m54g45nxbsqsageietky3h6t6ctyhf3ykzjhphww4rk2gopq
{
  CREATE TYPE default::chunk {
      CREATE MULTI LINK X_ref: default::chunk;
      CREATE PROPERTY content: std::str;
      CREATE PROPERTY payload: std::str;
  };
  CREATE TYPE default::chunks_holder {
      CREATE MULTI LINK chunks: default::chunk;
      CREATE PROPERTY chunk_strategy: std::str;
      CREATE PROPERTY description: std::str;
      CREATE PROPERTY emb_model: std::str;
      CREATE PROPERTY metadata: std::str;
  };
  CREATE TYPE default::File {
      CREATE MULTI LINK available_chunks: default::chunks_holder;
      CREATE PROPERTY description: std::str;
      CREATE PROPERTY filetype: std::str;
      CREATE REQUIRED PROPERTY name: std::str;
      CREATE PROPERTY path: std::str;
  };
  CREATE TYPE default::Folder {
      CREATE MULTI LINK files: default::File;
      CREATE MULTI LINK folders: default::Folder;
      CREATE PROPERTY description: std::str;
      CREATE REQUIRED PROPERTY name: std::str;
      CREATE PROPERTY path: std::str;
  };
  ALTER TYPE default::File {
      CREATE LINK parent: default::Folder;
  };
  ALTER TYPE default::Movie {
      DROP PROPERTY title2;
  };
  ALTER TYPE default::Movie {
      DROP PROPERTY title3;
  };
  ALTER TYPE default::Movie {
      DROP PROPERTY title;
  };
  ALTER TYPE default::Movie RENAME TO default::dashbord;
  ALTER TYPE default::Person RENAME TO default::collection;
  ALTER TYPE default::collection {
      CREATE LINK dashbord: default::dashbord;
      CREATE PROPERTY description: std::str;
  };
  ALTER TYPE default::dashbord {
      CREATE MULTI LINK files: default::File;
      CREATE MULTI LINK folders: default::Folder;
  };
};
