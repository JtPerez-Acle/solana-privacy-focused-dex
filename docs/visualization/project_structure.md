# Project Structure Visualization

```mermaid
graph TB
    subgraph Project Root
        direction TB
        Root[privacy-focused_DEX]
        Contracts[contracts/]
        Tests[tests/]
        Scripts[scripts/]
        Docs[docs/]
        Frontend[frontend/]
    end

    subgraph Contracts Structure
        direction TB
        Src[src/]
        Src --> Lib[lib.rs]
        Src --> SC[smart_contracts.rs]
        Src --> PL[privacy_layer.rs]
        CargoToml[Cargo.toml]
    end

    subgraph Test Structure
        direction TB
        Unit[unit_tests.rs]
        Integration[integration_tests.rs]
    end

    subgraph Script Structure
        direction TB
        Build[build.sh]
        Test[test.sh]
        Deploy[deploy.sh]
    end

    Root --> Contracts
    Root --> Tests
    Root --> Scripts
    Root --> Docs
    Root --> Frontend

    Contracts --> Src
    Contracts --> CargoToml
    Tests --> Unit
    Tests --> Integration
    Scripts --> Build
    Scripts --> Test
    Scripts --> Deploy