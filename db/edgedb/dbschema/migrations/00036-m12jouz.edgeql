CREATE MIGRATION m12jouzd5xgq2kdgmw6apw7dqdpguastkfl3zvmrlxl7zigobnsezq
    ONTO m12e4vutb5sckfowq4kkkuw4ngzsehaj5bco5iyqf2a4d27yd6sslq
{
  ALTER TYPE default::Chunk {
      ALTER PROPERTY content {
          SET default := '';
      };
  };
};
