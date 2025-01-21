import {createLocalVue, mount, shallowMount} from "@vue/test-utils";
import Vuex from "vuex";
import ResourcesModal from "../../src/components/ui/modals/ResourcesModal";
import LevelUpBuilding from "../../src/components/ui/LevelUpBuilding";



let resourceModalWrapper;
let store;
let getters;
let localVue;

beforeAll(() => {
    localVue = createLocalVue()
    localVue.component('LevelUpBuilding', LevelUpBuilding)
    localVue.use(Vuex)
})

beforeEach(() => {
    getters = {
        building: () => () => {
                return require("./mockData/test_building_data.json")
            }
    }

    store = new Vuex.Store({
        getters
    })

    resourceModalWrapper = shallowMount(ResourcesModal, {
        store,
        localVue,
    });
});

afterAll(() => {
    resourceModalWrapper.destroy()
})

describe('ResourcesModal', () => {
    it('should displays buildingName correctly when created', async () => {
        const expectedText = "Mine - Lv 1"
        const actualText = resourceModalWrapper.find("#buildingName").text() //html

        expect(actualText).toBe(expectedText)
    });

    it('should displays resources per hour correctly when resources is 80 stone per hour', async () => {
        const expectedText = "80 Stone / Hour"
        const actualText = resourceModalWrapper.find("#buildingDescription").text()

        expect(actualText).toBe(expectedText)
    });
});