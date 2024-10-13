CREATE MIGRATION m1dc5zvr3tfymmqmvcgib42lddm2o3p3sssgwmltrd2bof6wcv7yda
    ONTO m1uwekrn4ni4qs7ul7hfar4xemm5kkxlpswolcoyqj3xdhweomwjrq
{
  ALTER TYPE default::Movie {
      DROP LINK actors;
  };
};
