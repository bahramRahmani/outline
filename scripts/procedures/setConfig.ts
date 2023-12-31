
import { compat, types as T } from "../deps.ts";

export const setConfig: T.ExpectedExports.setConfig = async (
  effects: T.Effects,
  newConfig: T.Config,
) => {
  return compat.setConfig(effects, newConfig);
};
