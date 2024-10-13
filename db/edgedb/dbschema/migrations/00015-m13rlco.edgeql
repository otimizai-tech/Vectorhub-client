CREATE MIGRATION m13rlcois3vhdl4uh5xuy5xxwqg6hx6zz7thkoxatgk2kszs2vt25q
    ONTO m1rmutilpldbt367ilyco3dbczycyhbly5cx7vl5nrat752rpjh7ba
{
  ALTER TYPE default::Chunk {
      ALTER PROPERTY enabled {
          RENAME TO isEnabled;
      };
  };
  ALTER TYPE default::File {
      ALTER PROPERTY enabled {
          RENAME TO isEnabled;
      };
  };
  ALTER TYPE default::Folder {
      ALTER PROPERTY enabled {
          RENAME TO isEnabled;
      };
  };
};
