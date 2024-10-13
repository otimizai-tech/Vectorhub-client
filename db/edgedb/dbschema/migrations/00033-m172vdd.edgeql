CREATE MIGRATION m172vdda6jpuivsv4gl2xo3yh3h346qr2j22iasxki273ax6j6yrwq
    ONTO m1jogyijccv55pfxlqpw2xbd5sc7fdh6yr3kks5vbkdro6wkpbenrq
{
  ALTER TYPE default::File {
      ALTER PROPERTY location {
          RENAME TO loc;
      };
  };
  ALTER TYPE default::File {
      CREATE PROPERTY metadata: std::json;
  };
};
