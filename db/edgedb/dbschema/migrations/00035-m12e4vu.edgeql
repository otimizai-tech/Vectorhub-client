CREATE MIGRATION m12e4vutb5sckfowq4kkkuw4ngzsehaj5bco5iyqf2a4d27yd6sslq
    ONTO m1wznlz5fqdifmpb3luosgnk4snleozfi5eu226jydebnx7eew2isa
{
  ALTER TYPE default::File {
      CREATE PROPERTY description: std::str;
  };
};
