CREATE MIGRATION m1utoohuhtnsa6t2gyyw5pbiucj7boekcgjstgqjum3zoitfgdnv4q
    ONTO m1zclkeghskusvsprindlkrsqytdr7pavux7zuyimkeuhp3ijp6iaa
{
  ALTER TYPE default::File {
      DROP LINK parent;
  };
  ALTER TYPE default::File {
      CREATE PROPERTY enabled: std::bool;
  };
  ALTER TYPE default::Folder {
      DROP LINK files;
  };
  ALTER TYPE default::Folder {
      DROP LINK folders;
  };
  ALTER TYPE default::Folder {
      CREATE PROPERTY enabled: std::bool;
  };
};
