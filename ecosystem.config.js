// ecosystem.config.js
module.exports = {
    apps: [
      {
        name: "frontend",
        cwd: "./frontend",
        script: "npm",
        args: "start"
      },
      {
        name: "backend",
        cwd: "./backend",
        script: "./main",
        env: {
          PORT: 9000
        }
      }
    ]
  }
  