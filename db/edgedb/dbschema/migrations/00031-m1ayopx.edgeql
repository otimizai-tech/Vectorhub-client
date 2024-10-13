CREATE MIGRATION m1ayopxegzzbvroar56y6ec2qh33noww6spvrvmbnkhjo5oexxrkra
    ONTO m13ik56zcot5x2xi56dzpanisdqtdsiolrvvse6t3ymobcojchxaka
{
  ALTER TYPE default::File {
      DROP PROPERTY fileID;
  };
};
