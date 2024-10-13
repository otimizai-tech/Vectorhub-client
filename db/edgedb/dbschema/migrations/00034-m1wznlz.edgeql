CREATE MIGRATION m1wznlz5fqdifmpb3luosgnk4snleozfi5eu226jydebnx7eew2isa
    ONTO m172vdda6jpuivsv4gl2xo3yh3h346qr2j22iasxki273ax6j6yrwq
{
  ALTER TYPE default::File {
      CREATE LINK file: default::Chunk {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
  };
  ALTER TYPE default::File {
      DROP PROPERTY description;
  };
  ALTER TYPE default::File {
      DROP PROPERTY filetype;
  };
  ALTER TYPE default::File {
      DROP PROPERTY loc;
  };
  ALTER TYPE default::File {
      DROP PROPERTY metadata;
  };
};
