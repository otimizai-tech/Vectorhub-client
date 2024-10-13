CREATE MIGRATION m1jogyijccv55pfxlqpw2xbd5sc7fdh6yr3kks5vbkdro6wkpbenrq
    ONTO m1ayopxegzzbvroar56y6ec2qh33noww6spvrvmbnkhjo5oexxrkra
{
  ALTER TYPE default::Collection {
      ALTER LINK dashbord {
          SET MULTI;
      };
  };
  ALTER TYPE default::File {
      CREATE PROPERTY location: std::str;
  };
};
