import { types as T } from "../deps.ts";

export const health: T.ExpectedExports.health = {
    // deno-lint-ignore require-await
    async "main"(effects, duration) {
        return healthWeb(effects, duration);
    },
};

const healthWeb: T.ExpectedExports.health[""] = async (effects, duration) => {
    await guardDurationAboveMinimum({ duration, minimumTime: 5000 });

    return await effects.fetch("http://ipfs.embassy:5001/webui")
        .then((_) => ok)
        .catch((e) => {
            effects.error(`${e}`)
            return error(`The IPFS Web UI is unreachable`)
        });
};

// *** HELPER FUNCTIONS *** //

// Ensure the starting duration is past a minimum
const guardDurationAboveMinimum = (
    input: { duration: number; minimumTime: number },
) =>
    (input.duration <= input.minimumTime)
        ? Promise.reject(errorCode(60, "Starting"))
        : null;

const errorCode = (code: number, error: string) => ({
    "error-code": [code, error] as const,
});
const error = (error: string) => ({ error });
const ok = { result: null };
